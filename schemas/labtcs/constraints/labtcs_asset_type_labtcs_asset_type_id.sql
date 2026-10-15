-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_asset_type labtcs_asset_type_id
-- Type: CONSTRAINT

-- Name: labtcs_asset_type labtcs_asset_type_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_asset_type
    ADD CONSTRAINT labtcs_asset_type_id PRIMARY KEY (asset_type_id);


--
