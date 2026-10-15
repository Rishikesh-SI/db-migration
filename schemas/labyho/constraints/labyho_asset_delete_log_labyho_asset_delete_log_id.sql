-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_asset_delete_log labyho_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labyho_asset_delete_log labyho_asset_delete_log_id; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_asset_delete_log
    ADD CONSTRAINT labyho_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
