-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_asset_list_published_date
-- Type: INDEX

-- Name: ix_upp_asset_list_published_date; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_asset_list_published_date ON utt.utt_asset_list USING btree (published_date);


--
