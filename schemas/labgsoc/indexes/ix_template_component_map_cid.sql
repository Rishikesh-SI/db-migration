-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labgsoc; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labgsoc.labgsoc_template_component_map USING btree (component_id);


--
