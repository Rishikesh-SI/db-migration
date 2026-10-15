-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_asset_list_published_date
-- Type: INDEX

-- Name: ix_spz_asset_list_published_date; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_asset_list_published_date ON spz.spz_asset_list USING btree (published_date);


--
