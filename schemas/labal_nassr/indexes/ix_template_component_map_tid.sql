-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labal_nassr.labal_nassr_template_component_map USING btree (template_id);


--
