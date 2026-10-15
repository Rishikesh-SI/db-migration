-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_asset_list_published_date
-- Type: INDEX

-- Name: ix_upy_asset_list_published_date; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_asset_list_published_date ON upy.upy_asset_list USING btree (published_date);


--
