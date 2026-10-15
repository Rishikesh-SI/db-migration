-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_list_published_date
-- Type: INDEX

-- Name: ix_stn_asset_list_published_date; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_list_published_date ON stn.stn_asset_list USING btree (published_date);


--
