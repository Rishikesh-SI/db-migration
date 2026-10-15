-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_list labtri_asset_list_id
-- Type: CONSTRAINT

-- Name: labtri_asset_list labtri_asset_list_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_asset_list
    ADD CONSTRAINT labtri_asset_list_id PRIMARY KEY (asset_list_id);


--
