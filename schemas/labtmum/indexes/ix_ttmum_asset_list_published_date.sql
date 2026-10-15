-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labtmum; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labtmum.labtmum_asset_list USING btree (published_date);


--
