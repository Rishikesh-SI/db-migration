-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_asset_delete_log labal_nassr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labal_nassr_asset_delete_log labal_nassr_asset_delete_log_id; Type: CONSTRAINT; Schema: labal_nassr; Owner: -
--

ALTER TABLE ONLY labal_nassr.labal_nassr_asset_delete_log
    ADD CONSTRAINT labal_nassr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
