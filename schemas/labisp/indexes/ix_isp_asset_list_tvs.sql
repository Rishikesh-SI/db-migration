-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_isp_asset_list_tvs
-- Type: INDEX

-- Name: ix_isp_asset_list_tvs; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_isp_asset_list_tvs ON labisp.labisp_asset_list USING gin (tagged_entity);


--
