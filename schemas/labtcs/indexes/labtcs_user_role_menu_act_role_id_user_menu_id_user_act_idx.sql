-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_user_role_menu_act_role_id_user_menu_id_user_act_idx
-- Type: INDEX

-- Name: labtcs_user_role_menu_act_role_id_user_menu_id_user_act_idx; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE UNIQUE INDEX labtcs_user_role_menu_act_role_id_user_menu_id_user_act_idx ON labtcs.labtcs_user_role_menu_action_map2 USING btree (role_id, user_menu_id, user_action_id);


--
