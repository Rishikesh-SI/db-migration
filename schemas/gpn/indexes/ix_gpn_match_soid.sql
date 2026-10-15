-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_match_soid
-- Type: INDEX

-- Name: ix_gpn_match_soid; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_match_soid ON gpn.gpn_match USING btree (source_object_id);


--
