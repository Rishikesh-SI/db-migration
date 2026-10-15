-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labadkr.labadkr_asset_list USING btree (published_date);


--
