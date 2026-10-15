-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labukk.labukk_template_component_map USING btree (template_id);


--
