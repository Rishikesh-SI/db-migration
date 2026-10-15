-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labkkr_beta; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labkkr_beta.labkkr_template_component_map USING btree (component_id);


--
