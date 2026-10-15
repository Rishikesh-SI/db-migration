-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labeisl.labeisl_asset_list USING btree (published_date);


--
