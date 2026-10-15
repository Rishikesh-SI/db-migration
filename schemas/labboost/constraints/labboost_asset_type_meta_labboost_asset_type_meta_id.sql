-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_asset_type_meta labboost_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labboost_asset_type_meta labboost_asset_type_meta_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_asset_type_meta
    ADD CONSTRAINT labboost_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
