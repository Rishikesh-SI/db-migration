-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labecn_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labecn_v1.labecn_v1_asset_list USING btree (published_date);


--
