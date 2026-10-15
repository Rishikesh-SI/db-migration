-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_poll_asset_map mum_poll_asset_map_id
-- Type: CONSTRAINT

-- Name: dhm_poll_asset_map mum_poll_asset_map_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_poll_asset_map
    ADD CONSTRAINT mum_poll_asset_map_id PRIMARY KEY (poll_asset_map_id);


--
