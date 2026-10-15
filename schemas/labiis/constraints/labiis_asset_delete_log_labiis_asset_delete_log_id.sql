-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_asset_delete_log labiis_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labiis_asset_delete_log labiis_asset_delete_log_id; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_asset_delete_log
    ADD CONSTRAINT labiis_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
