-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_asset_list_published_date
-- Type: INDEX

-- Name: ix_hsl_asset_list_published_date; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_published_date ON hsl.hsl_asset_list USING btree (published_date);


--
