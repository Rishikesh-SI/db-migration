-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_asset_list_published_date
-- Type: INDEX

-- Name: ix_hsl_asset_list_published_date; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_published_date ON labhsl.labhsl_asset_list USING btree (published_date);


--
