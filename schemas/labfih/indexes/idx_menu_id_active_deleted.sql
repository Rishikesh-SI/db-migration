-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_menu_id_active_deleted
-- Type: INDEX

-- Name: idx_menu_id_active_deleted; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_menu_id_active_deleted ON labfih.labfih_menu_page_map USING btree (menu_id, page_id, is_active, is_deleted);


--
