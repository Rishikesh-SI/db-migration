-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_asset_delete_log mum_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: tmmimg_upd_asset_delete_log mum_asset_delete_log_id; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_asset_delete_log
    ADD CONSTRAINT mum_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
