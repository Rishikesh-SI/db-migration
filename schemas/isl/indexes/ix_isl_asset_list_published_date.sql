-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_asset_list_published_date
-- Type: INDEX

-- Name: ix_isl_asset_list_published_date; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_asset_list_published_date ON isl.isl_asset_list USING btree (published_date);


--
