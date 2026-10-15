-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_album_id
-- Type: INDEX

-- Name: ix_abp_album_id; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_album_id ON abpp.abp_album USING btree (album_id);


--
