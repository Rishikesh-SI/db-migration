-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_asset_list_aid
-- Type: INDEX

-- Name: ix_gsf_asset_list_aid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_asset_list_aid ON gsf.gsf_asset_list USING btree (asset_id);


--
