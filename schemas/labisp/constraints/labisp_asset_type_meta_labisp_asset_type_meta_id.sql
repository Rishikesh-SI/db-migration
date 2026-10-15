-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_asset_type_meta labisp_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labisp_asset_type_meta labisp_asset_type_meta_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_asset_type_meta
    ADD CONSTRAINT labisp_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
