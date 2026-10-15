-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_asset_list_title_alias
-- Type: INDEX

-- Name: ix_spz_asset_list_title_alias; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_asset_list_title_alias ON spz.spz_asset_list USING btree (title_alias);


--
