-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_ttmum_asset_list_published_date
-- Type: INDEX

-- Name: ix_ttmum_asset_list_published_date; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_published_date ON labmi.labmi_asset_list USING btree (published_date);


--
