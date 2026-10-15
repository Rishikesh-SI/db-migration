-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_hierarchy_parent_id
-- Type: INDEX

-- Name: idx_hierarchy_parent_id; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_hierarchy_parent_id ON labfih.labfih_hierarchy USING btree (parent_id);


--
