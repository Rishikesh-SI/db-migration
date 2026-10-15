-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_assetlist_published_date
-- Type: INDEX

-- Name: ix_assetlist_published_date; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_assetlist_published_date ON isl.isl_asset_list USING btree (published_date DESC);


--
