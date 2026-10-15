-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_hierarchy_level
-- Type: INDEX

-- Name: idx_hierarchy_level; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_hierarchy_level ON labfih.labfih_hierarchy USING btree (level);


--
