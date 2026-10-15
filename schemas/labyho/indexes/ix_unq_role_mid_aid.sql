-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_unq_role_mid_aid
-- Type: INDEX

-- Name: ix_unq_role_mid_aid; Type: INDEX; Schema: labyho; Owner: -
--

CREATE UNIQUE INDEX ix_unq_role_mid_aid ON labyho.labyho_user_role_menu_action_map2 USING btree (role_id, user_menu_id, user_action_id);


--
