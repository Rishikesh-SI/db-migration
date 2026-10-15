-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_asset_list_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aid ON labisp.labisp_asset_list USING btree (asset_id);


--
