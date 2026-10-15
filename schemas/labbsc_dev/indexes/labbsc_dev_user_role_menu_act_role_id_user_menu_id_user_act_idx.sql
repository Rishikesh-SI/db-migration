-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_role_menu_act_role_id_user_menu_id_user_act_idx
-- Type: INDEX

-- Name: labbsc_dev_user_role_menu_act_role_id_user_menu_id_user_act_idx; Type: INDEX; Schema: labbsc_dev; Owner: -
--

CREATE UNIQUE INDEX labbsc_dev_user_role_menu_act_role_id_user_menu_id_user_act_idx ON labbsc_dev.labbsc_dev_user_role_menu_action_map2 USING btree (role_id, user_menu_id, user_action_id);


--
