-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_series_redirect labwis_series_redirect_id
-- Type: CONSTRAINT

-- Name: labwis_series_redirect labwis_series_redirect_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_series_redirect
    ADD CONSTRAINT labwis_series_redirect_id PRIMARY KEY (redirect_id);


--
