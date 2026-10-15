-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labisl_v1; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labisl_v1.labisl_v1_asset_list USING btree (title_alias);


--
