import { isPlatformBrowser } from '@angular/common';

/**
 * Safely loads Leaflet library only in browser environment
 * Returns a promise that resolves to the Leaflet instance
 */
export async function loadLeaflet(): Promise<any> {
  // This will only run in browser environment
  if (typeof window !== 'undefined') {
    try {
      // Dynamic import of Leaflet
      const L = await import('leaflet');
      return L;
    } catch (error) {
      console.error('Error loading Leaflet:', error);
      throw error;
    }
  } else {
    // Return mock object for SSR
    return Promise.resolve(createLeafletMock());
  }
}

/**
 * Creates a mock Leaflet object with empty functions for SSR environment
 */
function createLeafletMock() {
  // This creates a mock Leaflet object that does nothing
  // to prevent errors during server-side rendering
  const noop = () => ({ 
    addTo: noop, 
    setView: noop, 
    bindPopup: noop,
    setLatLng: noop,
    openPopup: noop,
    removeLayer: noop
  });
  
  return {
    map: () => noop(),
    tileLayer: () => ({ addTo: noop }),
    marker: () => noop(),
    latLng: (lat: number, lng: number) => ({ lat, lng })
  };
}
