-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labtkr_beta.labtkr_template_component_map USING btree (component_id);


--
