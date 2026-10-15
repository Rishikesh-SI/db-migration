-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_asset_list_published_date
-- Type: INDEX

-- Name: ix_upp_asset_list_published_date; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_asset_list_published_date ON upp.upp_asset_list USING btree (published_date);


--
