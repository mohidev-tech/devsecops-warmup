package health

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestLive(t *testing.T) {
	rr := httptest.NewRecorder()
	Live(rr, httptest.NewRequest(http.MethodGet, "/healthz", nil))
	if rr.Code != http.StatusOK {
		t.Fatalf("expected 200, got %d", rr.Code)
	}
}

func TestReady(t *testing.T) {
	rr := httptest.NewRecorder()
	Ready(rr, httptest.NewRequest(http.MethodGet, "/readyz", nil))
	if rr.Code != http.StatusOK {
		t.Fatalf("expected 200, got %d", rr.Code)
	}
}
