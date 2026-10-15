-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labal_nassr.labal_nassr_entity_image_map USING btree (entity_master_id);


--
