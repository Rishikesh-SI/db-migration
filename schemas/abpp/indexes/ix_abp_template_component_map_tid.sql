-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_template_component_map_tid
-- Type: INDEX

-- Name: ix_abp_template_component_map_tid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_template_component_map_tid ON abpp.abp_template_component_map USING btree (template_id);


--
