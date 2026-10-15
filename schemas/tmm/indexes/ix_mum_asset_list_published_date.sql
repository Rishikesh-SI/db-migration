-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_asset_list_published_date
-- Type: INDEX

-- Name: ix_mum_asset_list_published_date; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_asset_list_published_date ON tmm.tmm_asset_list USING btree (published_date);


--
