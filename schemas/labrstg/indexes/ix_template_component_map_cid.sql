-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labrstg.labrstg_template_component_map USING btree (component_id);


--
