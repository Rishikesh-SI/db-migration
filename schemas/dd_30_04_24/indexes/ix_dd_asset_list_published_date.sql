-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_asset_list_published_date
-- Type: INDEX

-- Name: ix_dd_asset_list_published_date; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_asset_list_published_date ON dd_30_04_24.dd_asset_list USING btree (published_date);


--
