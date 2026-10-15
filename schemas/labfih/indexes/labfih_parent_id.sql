-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_parent_id
-- Type: INDEX

-- Name: labfih_parent_id; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX labfih_parent_id ON labfih.labfih_page USING btree (parent_id);


--
