-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labtkr_beta.labtkr_template_component_map USING btree (template_id);


--
