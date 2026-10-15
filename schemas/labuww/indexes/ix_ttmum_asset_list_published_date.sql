-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labuww.labuww_asset_list USING btree (published_date);


--
