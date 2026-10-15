-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: is_deleted
-- Type: INDEX

-- Name: is_deleted; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX is_deleted ON labfih.labfih_template_component_map_4_11_2024 USING btree (template_id, is_active, is_deleted);


--
