-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_asset_list labtcs_asset_list_id
-- Type: CONSTRAINT

-- Name: labtcs_asset_list labtcs_asset_list_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_asset_list
    ADD CONSTRAINT labtcs_asset_list_id PRIMARY KEY (asset_list_id);


--
