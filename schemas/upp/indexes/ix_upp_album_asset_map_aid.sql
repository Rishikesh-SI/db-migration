-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_album_asset_map_aid
-- Type: INDEX

-- Name: ix_upp_album_asset_map_aid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_album_asset_map_aid ON upp.upp_album_asset_map USING btree (album_id);


--
