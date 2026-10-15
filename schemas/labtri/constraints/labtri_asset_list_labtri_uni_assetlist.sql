-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_list labtri_uni_assetlist
-- Type: CONSTRAINT

-- Name: labtri_asset_list labtri_uni_assetlist; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_asset_list
    ADD CONSTRAINT labtri_uni_assetlist UNIQUE (title_alias, asset_type_id, language_id);


--
